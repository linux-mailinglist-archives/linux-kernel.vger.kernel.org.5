Return-Path: <linux-kernel+bounces-73750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C0385CA76
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E98961C217AC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBA0152DFE;
	Tue, 20 Feb 2024 22:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ut3nVGXN"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C36741AAC;
	Tue, 20 Feb 2024 22:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708467095; cv=none; b=Cu5A02ZiHSB/AUzFsDr8GVUcOgvsuNi4VvVBJxlpKQwQm/lQymq5Wz8xlPdG9EBSoD0OVlfhU0XlLkryFAuBUKtgSxPfwHOx7DAXWW47XvoNVekVkZc1rX+iIvV3y6J3fDvDqRxbpvG64hsetg6xlcbhDchUFuSklCjUpXx2mkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708467095; c=relaxed/simple;
	bh=tKTeDhASeG0RWYAHgz6Fzs9qCitdUnjZ6CXkAiZKXvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=falrPheztpIAd0xhf/91VxIW7oGZCguIZrqonnKevNBbShL+0r62Mc0zhiewgWAbBHZD5kJYPqyPP6f1iKbzJARzG1B5qzLjvty+cG7/oKe6MV4cVHV9TDPeDRhrtiN/MS91KzNBaj+cxGceKGByGzxXtPOXtyfvwzjT/U0G9Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ut3nVGXN; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-290ec261a61so3652396a91.0;
        Tue, 20 Feb 2024 14:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708467091; x=1709071891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3IuuZevvt9m3yo9p2HXJBAPvXWAr/TbuTUlURwRBg8=;
        b=Ut3nVGXNeb54LoRZO/TvywMoy5mtRrw/mliIEmn5ehVBYSuWZ4ztV/QGnQVxt95R1+
         2rCrrP4m/4Opp1b8oeWnNByAOl9rFbd5PPjqbzSNrPIoeqeyzbrtzI5tQF8bHZ6In1r5
         dQThbcFWazkq1asPmmbTr5Mdy+nxiV+c7g0C1K2+bPev8GUtj69F7afWd93znM3QU4wZ
         Xli1kk6LyfY2ECa34xIR/6iL/7N6jlSbTTj2VSea5OWebexQ5fJCytbMI+kePZsuIBBi
         2QRVVbPeEdANTVLFzoBH8hXB0DM9b/uNhznrt7qTB/K5gNb65k+pP7RaGzXfx0KZRjiM
         LSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708467091; x=1709071891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3IuuZevvt9m3yo9p2HXJBAPvXWAr/TbuTUlURwRBg8=;
        b=Owi8dPBEyVojzNyomxFqJdtFhNWwyibupYD2xgpVFQgRfSH0SBcgPtgubJ1VZlq8iw
         auQmy1/5GRFpysHBmir6CpUbFaMHFnHE7HctkXicQBazLjKlHt+L8PjYSG7CVT07uR0L
         EXj6aImYW2+lwSsmKB37Nyn2uC4sdfpTNH8kd0qYePhsGjAfq5kVERm0phEGPAA/Oqa1
         hTTmVIxk+kTjtS5KhjY9+AufqGd6sMgDXhT0DeLfi6nxz9U9zgPsgKQzHjyM18PfZ/IA
         tiE6vzIaIY+bpDvAAqcj06uBvk5Bu+rwyKVmbnldQs44qQu0StdKfxy81raDsN9+G4zK
         M9Ig==
X-Forwarded-Encrypted: i=1; AJvYcCWPMFCXAcBD5nXaCW1IScRHI4gcinIBVMaD2SA6+cqSyR8HQqQ/f+pqz6o+mjADCPLxyeniGniaXKwVug/dojr3H1TgskLv/KC95uME
X-Gm-Message-State: AOJu0YwN7a/bEadhR06hcN2a6ImmypNDxSgQIBQ9kDUt7nlHf1ap47KZ
	KbUnCASOmCeOxHa0mTvZ5/dciQJO5H84GegZGKdubwl+t5UgpQAyTwFaZIKQNuZPlEepx3aWnf/
	XWXGSlT1s77crC+jWKorw3ecgpz4=
X-Google-Smtp-Source: AGHT+IFG9SSlsk300B/G5/urBoi9Ylrb7pFPpNpbP+4qoDay9Bs2IJxSRmVUvKyguuXsMruDeHAUmzd3zP59vuLdTzM=
X-Received: by 2002:a17:90a:8989:b0:298:bce9:47b4 with SMTP id
 v9-20020a17090a898900b00298bce947b4mr13340558pjn.48.1708467091171; Tue, 20
 Feb 2024 14:11:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220205633.096363225@linuxfoundation.org>
In-Reply-To: <20240220205633.096363225@linuxfoundation.org>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Tue, 20 Feb 2024 23:11:17 +0100
Message-ID: <CADo9pHhGS++-4xi5WcOgTZvaHwymTGt+iX0ZL0DXgaO8+ZNMeg@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/309] 6.7.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Luna Jernberg <droidbittin@gmail.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Works fine on my desktop with model name    : AMD Ryzen 5 5600 6-Core
Processor and Arch Linux

Tested-by: Luna Jernberg <droidbittin@gmail.com>

Den tis 20 feb. 2024 kl 22:27 skrev Greg Kroah-Hartman
<gregkh@linuxfoundation.org>:
>
> This is the start of the stable review cycle for the 6.7.6 release.
> There are 309 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 22 Feb 2024 20:55:42 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.7.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
> Pseudo-Shortlog of commits:
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 6.7.6-rc1
>
> NeilBrown <neilb@suse.de>
>     nfsd: don't take fi_lock in nfsd_break_deleg_cb()
>
> Jozsef Kadlecsik <kadlec@netfilter.org>
>     netfilter: ipset: Missing gc cancellations fixed
>
> Jozsef Kadlecsik <kadlec@netfilter.org>
>     netfilter: ipset: fix performance regression in swap operation
>
> Mark Brown <broonie@kernel.org>
>     usb: typec: tpcm: Fix issues with power being removed during reset
>
> Damien Le Moal <dlemoal@kernel.org>
>     block: fix partial zone append completion handling in req_bio_endio()
>
> Junxiao Bi <junxiao.bi@oracle.com>
>     md: bypass block throttle for superblock update
>
> Steven Rostedt (Google) <rostedt@goodmis.org>
>     tracing: Inform kmemleak of saved_cmdlines allocation
>
> Petr Pavlu <petr.pavlu@suse.com>
>     tracing: Fix HAVE_DYNAMIC_FTRACE_WITH_REGS ifdef
>
> Oleg Nesterov <oleg@redhat.com>
>     fs/proc: do_task_stat: use sig->stats_lock to gather the threads/chil=
dren stats
>
> Oleg Nesterov <oleg@redhat.com>
>     fs/proc: do_task_stat: move thread_group_cputime_adjusted() outside o=
f lock_task_sighand()
>
> Konrad Dybcio <konrad.dybcio@linaro.org>
>     pmdomain: core: Move the unused cleanup to a _sync initcall
>
> Oleksij Rempel <o.rempel@pengutronix.de>
>     can: j1939: Fix UAF in j1939_sk_match_filter during setsockopt(SO_J19=
39_FILTER)
>
> Ziqi Zhao <astrajoan@yahoo.com>
>     can: j1939: prevent deadlock by changing j1939_socks_lock to rwlock
>
> Maxime Jayat <maxime.jayat@mobile-devices.fr>
>     can: netlink: Fix TDCO calculation using the old data bittiming
>
> Maximilian Heyne <mheyne@amazon.de>
>     xen/events: close evtchn after mapping cleanup
>
> Nuno Sa <nuno.sa@analog.com>
>     of: property: fix typo in io-channels
>
> Vegard Nossum <vegard.nossum@oracle.com>
>     docs: kernel_feat.py: fix build error for missing files
>
> Jan Kara <jack@suse.cz>
>     blk-wbt: Fix detection of dirty-throttled tasks
>
> Huacai Chen <chenhuacai@kernel.org>
>     LoongArch: Fix earlycon parameter if KASAN enabled
>
> Prakash Sangappa <prakash.sangappa@oracle.com>
>     mm: hugetlb pages should not be reserved by shmat() if SHM_NORESERVE
>
> Oscar Salvador <osalvador@suse.de>
>     fs,hugetlb: fix NULL pointer dereference in hugetlbs_fill_super
>
> Dave Airlie <airlied@redhat.com>
>     nouveau/gsp: use correct size for registry rpc.
>
> Rishabh Dave <ridave@redhat.com>
>     ceph: prevent use-after-free in encode_cap_msg()
>
> Shradha Gupta <shradhagupta@linux.microsoft.com>
>     hv_netvsc: Register VF in netvsc_probe if NET_DEVICE_REGISTER missed
>
> Petr Tesarik <petr@tesarici.cz>
>     net: stmmac: protect updates of 64-bit statistics counters
>
> Jan Kiszka <jan.kiszka@siemens.com>
>     riscv/efistub: Ensure GP-relative addressing is not used
>
> Geert Uytterhoeven <geert+renesas@glider.be>
>     pmdomain: renesas: r8a77980-sysc: CR7 must be always on
>
> Sinthu Raja <sinthu.raja@ti.com>
>     net: ethernet: ti: cpsw_new: enable mac_managed_pm to fix mdio
>
> SeongJae Park <sj@kernel.org>
>     mm/damon/sysfs-schemes: fix wrong DAMOS tried regions update timeout =
setup
>
> Alexandra Winter <wintera@linux.ibm.com>
>     s390/qeth: Fix potential loss of L3-IP@ in case of network issues
>
> Sinthu Raja <sinthu.raja@ti.com>
>     net: ethernet: ti: cpsw: enable mac_managed_pm to fix mdio
>
> Christian Brauner <brauner@kernel.org>
>     fs: relax mount_setattr() permission checks
>
> Daniel Bristot de Oliveira <bristot@kernel.org>
>     tools/rtla: Fix Makefile compiler options for clang
>
> Daniel Bristot de Oliveira <bristot@kernel.org>
>     tools/rtla: Fix uninitialized bucket/data->bucket_size warning
>
> John Kacur <jkacur@redhat.com>
>     tools/rtla: Exit with EXIT_SUCCESS when help is invoked
>
> Daniel Bristot de Oliveira <bristot@kernel.org>
>     tools/rtla: Fix clang warning about mount_point var size
>
> limingming3 <limingming890315@gmail.com>
>     tools/rtla: Replace setting prio with nice for SCHED_OTHER
>
> Daniel Bristot de Oliveira <bristot@kernel.org>
>     tools/rtla: Remove unused sched_getattr() function
>
> Daniel Bristot de Oliveira <bristot@kernel.org>
>     tools/rv: Fix Makefile compiler options for clang
>
> Daniel Bristot de Oliveira <bristot@kernel.org>
>     tools/rv: Fix curr_reactor uninitialized variable
>
> Mario Limonciello <mario.limonciello@amd.com>
>     ASoC: amd: yc: Add DMI quirk for Lenovo Ideapad Pro 5 16ARP8
>
> Gergo Koteles <soyer@irl.hu>
>     ASoC: tas2781: add module parameter to tascodec_init()
>
> Curtis Malainey <cujomalainey@chromium.org>
>     ASoC: SOF: IPC3: fix message bounds on ipc ops
>
> Easwar Hariharan <eahariha@linux.microsoft.com>
>     arm64: Subscribe Microsoft Azure Cobalt 100 to ARM Neoverse N2 errata
>
> Mark Brown <broonie@kernel.org>
>     arm64/signal: Don't assume that TIF_SVE means we saved SVE state
>
> Fred Ai <fred.ai@bayhubtech.com>
>     mmc: sdhci-pci-o2micro: Fix a warm reboot issue that disk can't be de=
tected by BIOS
>
> Damien Le Moal <dlemoal@kernel.org>
>     zonefs: Improve error handling
>
> Sebastian Ene <sebastianene@google.com>
>     KVM: arm64: Fix circular locking dependency
>
> Christian Borntraeger <borntraeger@linux.ibm.com>
>     KVM: s390: vsie: fix race during shadow creation
>
> Steve French <stfrench@microsoft.com>
>     smb: Fix regression in writes when non-standard maximum write size ne=
gotiated
>
> Paulo Alcantara <pc@manguebit.com>
>     smb: client: set correct id, uid and cruid for multiuser automounts
>
> Mohammad Rahimi <rahimi.mhmmd@gmail.com>
>     thunderbolt: Fix setting the CNS bit in ROUTER_CS_5
>
> Marc Zyngier <maz@kernel.org>
>     irqchip/gic-v3-its: Fix GICv4.1 VPE affinity update
>
> Marc Zyngier <maz@kernel.org>
>     irqchip/gic-v3-its: Restore quirk probing for ACPI-based systems
>
> Doug Berger <opendmb@gmail.com>
>     irqchip/irq-brcmstb-l2: Add write memory barrier before exit
>
> Dan Carpenter <dan.carpenter@linaro.org>
>     PCI: dwc: Fix a 64bit bug in dw_pcie_ep_raise_msix_irq()
>
> Emmanuel Grumbach <emmanuel.grumbach@intel.com>
>     wifi: iwlwifi: mvm: fix a crash when we run out of stations
>
> Johannes Berg <johannes.berg@intel.com>
>     wifi: mac80211: reload info pointer in ieee80211_tx_dequeue()
>
> Johannes Berg <johannes.berg@intel.com>
>     wifi: cfg80211: fix wiphy delayed work queueing
>
> Johannes Berg <johannes.berg@intel.com>
>     wifi: iwlwifi: fix double-free bug
>
> Daniel de Villiers <daniel.devilliers@corigine.com>
>     nfp: flower: prevent re-adding mac index for bonded port
>
> James Hershaw <james.hershaw@corigine.com>
>     nfp: enable NETDEV_XDP_ACT_REDIRECT feature flag
>
> Daniel Basilio <daniel.basilio@corigine.com>
>     nfp: use correct macro for LengthSelect in BAR config
>
> Herbert Xu <herbert@gondor.apana.org.au>
>     crypto: algif_hash - Remove bogus SGL free on zero-length error path
>
> Kim Phillips <kim.phillips@amd.com>
>     crypto: ccp - Fix null pointer dereference in __sev_platform_shutdown=
_locked
>
> Ryusuke Konishi <konishi.ryusuke@gmail.com>
>     nilfs2: fix hang in nilfs_lookup_dirty_data_buffers()
>
> Ryusuke Konishi <konishi.ryusuke@gmail.com>
>     nilfs2: fix data corruption in dsync block recovery for small block s=
izes
>
> Shuming Fan <shumingf@realtek.com>
>     ALSA: hda/realtek: add IDs for Dell dual spk platform
>
> bo liu <bo.liu@senarytech.com>
>     ALSA: hda/conexant: Add quirk for SWS JS201D
>
> Eniac Zhang <eniac-xw.zhang@hp.com>
>     ALSA: hda/realtek: fix mute/micmute LED For HP mt645
>
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     gpiolib: add gpiod_to_gpio_device() stub for !GPIOLIB
>
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     gpiolib: add gpio_device_get_base() stub for !GPIOLIB
>
> Alexander Stein <alexander.stein@ew.tq-group.com>
>     mmc: slot-gpio: Allow non-sleeping GPIO ro
>
> Jens Axboe <axboe@kernel.dk>
>     io_uring/net: fix multishot accept overflow handling
>
> Steve Wahl <steve.wahl@hpe.com>
>     x86/mm/ident_map: Use gbpages only where full GB page should be mappe=
d.
>
> Mingwei Zhang <mizhang@google.com>
>     KVM: x86/pmu: Fix type length error when reading pmu->fixed_ctr_ctrl
>
> Prasad Pandit <pjp@fedoraproject.org>
>     KVM: x86: make KVM_REQ_NMI request iff NMI pending for vcpu
>
> Andrei Vagin <avagin@google.com>
>     x86/fpu: Stop relying on userspace for info to fault in xsave buffer
>
> Aleksander Mazur <deweloper@wp.pl>
>     x86/Kconfig: Transmeta Crusoe is CPU family 5, not 6
>
> Jiri Slaby (SUSE) <jirislaby@kernel.org>
>     serial: mxs-auart: fix tx
>
> Jiri Slaby (SUSE) <jirislaby@kernel.org>
>     serial: core: introduce uart_port_tx_flags()
>
> Shrikanth Hegde <sshegde@linux.ibm.com>
>     powerpc/pseries: fix accuracy of stolen time
>
> David Engraf <david.engraf@sysgo.com>
>     powerpc/cputable: Add missing PPC_FEATURE_BOOKE on PPC64 Book-E
>
> Naveen N Rao <naveen@kernel.org>
>     powerpc/64: Set task pt_regs->link to the LR value on scv entry
>
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>     ftrace: Fix DIRECT_CALLS to use SAVE_REGS by default
>
> Hugo Villeneuve <hvilleneuve@dimonoff.com>
>     serial: max310x: prevent infinite while() loop in port startup
>
> Hugo Villeneuve <hvilleneuve@dimonoff.com>
>     serial: max310x: fail probe if clock crystal is unstable
>
> Hugo Villeneuve <hvilleneuve@dimonoff.com>
>     serial: max310x: improve crystal stable clock detection
>
> Hugo Villeneuve <hvilleneuve@dimonoff.com>
>     serial: max310x: set default value when reading clock ready bit
>
> Gui-Dong Han <2045gemini@gmail.com>
>     serial: core: Fix atomicity violation in uart_tiocmget
>
> Hui Zhou <hui.zhou@corigine.com>
>     nfp: flower: fix hardware offload for the transfer layer port
>
> Hui Zhou <hui.zhou@corigine.com>
>     nfp: flower: add hardware offload check for post ct entry
>
> Andrew Lunn <andrew@lunn.ch>
>     net: dsa: mv88e6xxx: Fix failed probe due to unsupported C45 reads
>
> Vincent Donnefort <vdonnefort@google.com>
>     ring-buffer: Clean ring_buffer_poll_wait() error return
>
> Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
>     hv_netvsc: Fix race condition between netvsc_probe and netvsc_remove
>
> Lijo Lazar <lijo.lazar@amd.com>
>     drm/amdgpu: Avoid fetching VRAM vendor info
>
> Tom Chung <chiahsuan.chung@amd.com>
>     drm/amd/display: Preserve original aspect ratio in create stream
>
> Roman Li <roman.li@amd.com>
>     drm/amd/display: Fix array-index-out-of-bounds in dcn35_clkmgr
>
> Nathan Chancellor <nathan@kernel.org>
>     drm/amd/display: Increase frame-larger-than for all display_mode_vba =
files
>
> Fangzhi Zuo <jerry.zuo@amd.com>
>     drm/amd/display: Fix MST Null Ptr for RV
>
> Thong <thong.thai@amd.com>
>     drm/amdgpu/soc21: update VCN 4 max HEVC encoding resolution
>
> Philip Yang <Philip.Yang@amd.com>
>     drm/prime: Support page array >=3D 4GB
>
> Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>     drm/i915/dp: Limit SST link rate to <=3D8.1Gbps
>
> Zhikai Zhai <zhikai.zhai@amd.com>
>     drm/amd/display: Add align done check
>
> Rob Clark <robdclark@chromium.org>
>     drm/msm: Wire up tlb ops
>
> Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>     drm/buddy: Fix alloc_range() error handling code
>
> Timur Tabi <ttabi@nvidia.com>
>     drm/nouveau: fix several DMA buffer leaks
>
> Fedor Pchelkin <pchelkin@ispras.ru>
>     ksmbd: free aux buffer if ksmbd_iov_pin_rsp_read fails
>
> Oleg Nesterov <oleg@redhat.com>
>     getrusage: use sig->stats_lock rather than lock_task_sighand()
>
> Oleg Nesterov <oleg@redhat.com>
>     getrusage: move thread_group_cputime_adjusted() outside of lock_task_=
sighand()
>
> Steven Rostedt (Google) <rostedt@goodmis.org>
>     eventfs: Keep all directory links at 1
>
> Steven Rostedt (Google) <rostedt@goodmis.org>
>     eventfs: Remove fsnotify*() functions from lookup()
>
> Steven Rostedt (Google) <rostedt@goodmis.org>
>     eventfs: Restructure eventfs_inode structure to be more condensed
>
> Steven Rostedt (Google) <rostedt@goodmis.org>
>     eventfs: Warn if an eventfs_inode is freed without is_freed being set
>
> Linus Torvalds <torvalds@linux-foundation.org>
>     eventfs: Get rid of dentry pointers without refcounts
>
> Linus Torvalds <torvalds@linux-foundation.org>
>     eventfs: Clean up dentry ops and add revalidate function
>
> Linus Torvalds <torvalds@linux-foundation.org>
>     eventfs: Remove unused d_parent pointer field
>
> Linus Torvalds <torvalds@linux-foundation.org>
>     tracefs: dentry lookup crapectomy
>
> Linus Torvalds <torvalds@linux-foundation.org>
>     tracefs: Avoid using the ei->dentry pointer unnecessarily
>
> Linus Torvalds <torvalds@linux-foundation.org>
>     eventfs: Initialize the tracefs inode properly
>
> Steven Rostedt (Google) <rostedt@goodmis.org>
>     tracefs: Zero out the tracefs_inode when allocating it
>
> Steven Rostedt (Google) <rostedt@goodmis.org>
>     eventfs: Save directory inodes in the eventfs_inode structure
>
> Erick Archer <erick.archer@gmx.com>
>     eventfs: Use kcalloc() instead of kzalloc()
>
> Steven Rostedt (Google) <rostedt@goodmis.org>
>     eventfs: Do not create dentries nor inodes in iterate_shared
>
> Steven Rostedt (Google) <rostedt@goodmis.org>
>     eventfs: Have the inodes all for files and directories all be the sam=
e
>
> Steven Rostedt (Google) <rostedt@goodmis.org>
>     eventfs: Shortcut eventfs_iterate() by skipping entries already read
>
> Steven Rostedt (Google) <rostedt@goodmis.org>
>     eventfs: Read ei->entries before ei->children in eventfs_iterate()
>
> Steven Rostedt (Google) <rostedt@goodmis.org>
>     eventfs: Do ctx->pos update for all iterations in eventfs_iterate()
>
> Steven Rostedt (Google) <rostedt@goodmis.org>
>     eventfs: Have eventfs_iterate() stop immediately if ei->is_freed is s=
et
>
> Steven Rostedt (Google) <rostedt@goodmis.org>
>     eventfs: Stop using dcache_readdir() for getdents()
>
> Steven Rostedt (Google) <rostedt@goodmis.org>
>     eventfs: Remove "lookup" parameter from create_dir/file_dentry()
>
> Sean Young <sean@mess.org>
>     media: rc: bpf attach/detach requires write permission
>
> Eugen Hristev <eugen.hristev@collabora.com>
>     pmdomain: mediatek: fix race conditions with genpd
>
> Sam Protsenko <semen.protsenko@linaro.org>
>     iio: pressure: bmp280: Add missing bmp085 to SPI id table
>
> Randy Dunlap <rdunlap@infradead.org>
>     iio: imu: bno055: serdev requires REGMAP
>
> Nuno Sa <nuno.sa@analog.com>
>     iio: imu: adis: ensure proper DMA alignment
>
> Nuno Sa <nuno.sa@analog.com>
>     iio: adc: ad_sigma_delta: ensure proper DMA alignment
>
> Mario Limonciello <mario.limonciello@amd.com>
>     iio: accel: bma400: Fix a compilation problem
>
> Nuno Sa <nuno.sa@analog.com>
>     iio: commom: st_sensors: ensure proper DMA alignment
>
> Dinghao Liu <dinghao.liu@zju.edu.cn>
>     iio: core: fix memleak in iio_device_register_sysfs
>
> zhili.liu <zhili.liu@ucas.com.cn>
>     iio: magnetometer: rm3100: add boundary check for the value read from=
 RM3100_REG_TMRC
>
> David Schiller <david.schiller@jku.at>
>     staging: iio: ad5933: fix type mismatch regression
>
> Tejun Heo <tj@kernel.org>
>     Revert "workqueue: Override implicit ordered attribute in workqueue_a=
pply_unbound_cpumask()"
>
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>     tracing/probes: Fix to search structure fields correctly
>
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>     tracing/probes: Fix to set arg size and fmt after setting type from B=
TF
>
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>     tracing/probes: Fix to show a parse error for bad type for $comm
>
> Thorsten Blum <thorsten.blum@toblux.com>
>     tracing/synthetic: Fix trace_string() return value
>
> Steven Rostedt (Google) <rostedt@goodmis.org>
>     tracing: Fix wasted memory in saved_cmdlines logic
>
> Daniel Bristot de Oliveira <bristot@kernel.org>
>     tracing/timerlat: Move hrtimer_init to timerlat_fd open()
>
> Baokun Li <libaokun1@huawei.com>
>     ext4: avoid bb_free and bb_fragments inconsistency in mb_free_blocks(=
)
>
> Baokun Li <libaokun1@huawei.com>
>     ext4: fix double-free of blocks due to wrong extents moved_len
>
> Ekansh Gupta <quic_ekangupt@quicinc.com>
>     misc: fastrpc: Mark all sessions as invalid in cb_remove
>
> Carlos Llamas <cmllamas@google.com>
>     binder: signal epoll threads of self-work
>
> Andy Chi <andy.chi@canonical.com>
>     ALSA: hda/realtek: fix mute/micmute LEDs for HP ZBook Power
>
> Vitaly Rodionov <vitalyr@opensource.cirrus.com>
>     ALSA: hda/cs8409: Suppress vmaster control for Dolphin models
>
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     ASoC: codecs: wcd938x: handle deferred probe
>
> Kailang Yang <kailang@realtek.com>
>     ALSA: hda/realtek - Add speaker pin verbtable for Dell dual speaker p=
latform
>
> Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
>     ALSA: hda/realtek: Enable headset mic on Vaio VJFE-ADL
>
> Nathan Chancellor <nathan@kernel.org>
>     modpost: Add '.ltext' and '.ltext.*' to TEXT_SECTIONS
>
> Nathan Chancellor <nathan@kernel.org>
>     um: Fix adding '-no-pie' for clang
>
> Jan Beulich <jbeulich@suse.com>
>     xen-netback: properly sync TX responses
>
> Helge Deller <deller@gmx.de>
>     parisc: BTLB: Fix crash when setting up BTLB at CPU bringup
>
> Helge Deller <deller@gmx.de>
>     parisc: Fix random data corruption from exception handler
>
> Esben Haabendal <esben@geanix.com>
>     net: stmmac: do not clear TBS enable bit on link up/down
>
> Nikita Zhandarovich <n.zhandarovich@fintech.ru>
>     net: hsr: remove WARN_ONCE() in send_hsr_supervision_frame()
>
> Fedor Pchelkin <pchelkin@ispras.ru>
>     nfc: nci: free rx_data_reassembly skb on NCI device cleanup
>
> Nathan Chancellor <nathan@kernel.org>
>     kbuild: Fix changing ELF file type for output of gen_btf for big endi=
an
>
> Jos=C3=A9 Relvas <josemonsantorelvas@gmail.com>
>     ALSA: hda/realtek: Apply headset jack quirk for non-bass alc287 think=
pads
>
> Takashi Sakamoto <o-takashi@sakamocchi.jp>
>     firewire: core: correct documentation of fw_csr_string() kernel API
>
> Ondrej Mosnacek <omosnace@redhat.com>
>     lsm: fix the logic in security_inode_getsecctx()
>
> Ondrej Mosnacek <omosnace@redhat.com>
>     lsm: fix default return value of the socket_getpeersec_*() hooks
>
> Fangzhi Zuo <jerry.zuo@amd.com>
>     drm/amd/display: Fix dcn35 8k30 Underflow/Corruption Issue
>
> Wenjing Liu <wenjing.liu@amd.com>
>     drm/amd/display: fix incorrect mpc_combine array size
>
> David McFarland <corngood@gmail.com>
>     drm/amd: Don't init MEC2 firmware when it fails to load
>
> Friedrich Vock <friedrich.vock@gmx.de>
>     drm/amdgpu: Reset IH OVERFLOW_CLEAR bit
>
> Sebastian Ott <sebott@redhat.com>
>     drm/virtio: Set segment size for virtio_gpu device
>
> Vaishnav Achath <vaishnav.a@ti.com>
>     spi: omap2-mcspi: Revert FIFO support without DMA
>
> Keqi Wang <wangkeqi_chris@163.com>
>     connector/cn_proc: revert "connector: Fix proc_event_num_listeners co=
unt not cleared"
>
> Rob Clark <robdclark@chromium.org>
>     Revert "drm/msm/gpu: Push gpu lock down past runpm"
>
> Mario Limonciello <mario.limonciello@amd.com>
>     Revert "drm/amd: flush any delayed gfxoff on suspend entry"
>
> Lee Duncan <lduncan@suse.com>
>     scsi: Revert "scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock"
>
> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>     media: Revert "media: rkisp1: Drop IRQF_SHARED"
>
> Michael Ellerman <mpe@ellerman.id.au>
>     Revert "powerpc/pseries/iommu: Fix iommu initialisation during DLPAR =
add"
>
> Paolo Abeni <pabeni@redhat.com>
>     mptcp: really cope with fastopen race
>
> Geliang Tang <geliang@kernel.org>
>     mptcp: check addrs list in userspace_pm_get_local_id
>
> Paolo Abeni <pabeni@redhat.com>
>     mptcp: fix rcv space initialization
>
> Paolo Abeni <pabeni@redhat.com>
>     mptcp: drop the push_pending field
>
> Geliang Tang <geliang.tang@linux.dev>
>     selftests: mptcp: add mptcp_lib_kill_wait
>
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>     selftests: mptcp: allow changing subtests prefix
>
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>     selftests: mptcp: increase timeout to 30 min
>
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>     selftests: mptcp: add missing kconfig for NF Mangle
>
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>     selftests: mptcp: add missing kconfig for NF Filter in v6
>
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>     selftests: mptcp: add missing kconfig for NF Filter
>
> Paolo Abeni <pabeni@redhat.com>
>     mptcp: fix data re-injection from stale subflow
>
> Arnd Bergmann <arnd@arndb.de>
>     kallsyms: ignore ARMv4 thunks along with others
>
> Radek Krejci <radek.krejci@oracle.com>
>     modpost: trim leading spaces when processing source files list
>
> Jean Delvare <jdelvare@suse.de>
>     i2c: i801: Fix block process call transactions
>
> Arnd Bergmann <arnd@arndb.de>
>     i2c: pasemi: split driver into two separate modules
>
> Shivaprasad G Bhat <sbhat@linux.ibm.com>
>     powerpc/iommu: Fix the missing iommu_group_put() during platform doma=
in attach
>
> Michael Ellerman <mpe@ellerman.id.au>
>     powerpc/kasan: Limit KASAN thread size increase to 32KB
>
> Marc Zyngier <maz@kernel.org>
>     irqchip/gic-v3-its: Handle non-coherent GICv4 redistributors
>
> Bibo Mao <maobibo@loongson.cn>
>     irqchip/loongson-eiointc: Use correct struct type in eiointc_domain_a=
lloc()
>
> Viken Dadhaniya <quic_vdadhani@quicinc.com>
>     i2c: qcom-geni: Correct I2C TRE sequence
>
> Dan Carpenter <dan.carpenter@linaro.org>
>     cifs: fix underflow in parse_server_interfaces()
>
> Cosmin Tanislav <demonsingur@gmail.com>
>     iio: adc: ad4130: only set GPIO_CTRL if pin is unused
>
> Cosmin Tanislav <demonsingur@gmail.com>
>     iio: adc: ad4130: zero-initialize clock init data
>
> Alex Williamson <alex.williamson@redhat.com>
>     PCI: Fix active state requirement in PME polling
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Revert "kobject: Remove redundant checks for whether ktype is NULL"
>
> Jiangfeng Xiao <xiaojiangfeng@huawei.com>
>     powerpc/kasan: Fix addr error caused by page alignment
>
> Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
>     powerpc/6xx: set High BAT Enable flag on G2_LE cores
>
> Gaurav Batra <gbatra@linux.ibm.com>
>     powerpc/pseries/iommu: Fix iommu initialisation during DLPAR add
>
> Saravana Kannan <saravanak@google.com>
>     driver core: fw_devlink: Improve detection of overlapping cycles
>
> Zhipeng Lu <alexious@zju.edu.cn>
>     media: ir_toy: fix a memleak in irtoy_tx
>
> Konrad Dybcio <konrad.dybcio@linaro.org>
>     interconnect: qcom: sm8550: Enable sync_state
>
> Konrad Dybcio <konrad.dybcio@linaro.org>
>     interconnect: qcom: sc8180x: Mark CO0 BCM keepalive
>
> Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
>     usb: dwc3: gadget: Fix NULL pointer dereference in dwc3_gadget_suspen=
d
>
> Udipto Goswami <quic_ugoswami@quicinc.com>
>     usb: core: Prevent null pointer dereference in update_port_device_sta=
te
>
> Xu Yang <xu.yang_2@nxp.com>
>     usb: chipidea: core: handle power lost in workqueue
>
> yuan linyu <yuanlinyu@hihonor.com>
>     usb: f_mass_storage: forbid async queue when shutdown happen
>
> Oliver Neukum <oneukum@suse.com>
>     USB: hub: check for alternate port before enabling A_ALT_HNP_SUPPORT
>
> Christian A. Ehrhardt <lk@c--e.de>
>     usb: ucsi_acpi: Fix command completion handling
>
> Sean Anderson <sean.anderson@seco.com>
>     usb: ulpi: Fix debugfs directory leak
>
> Christian A. Ehrhardt <lk@c--e.de>
>     usb: ucsi: Add missing ppm_lock
>
> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>     iio: hid-sensor-als: Return 0 for HID_USAGE_SENSOR_TIME_TIMESTAMP
>
> Jason Gerecke <killertofu@gmail.com>
>     HID: wacom: Do not register input devices until after hid_hw_start
>
> Tatsunosuke Tobita <tatsunosuke.tobita@wacom.com>
>     HID: wacom: generic: Avoid reporting a serial of '0' to userspace
>
> Johan Hovold <johan+linaro@kernel.org>
>     HID: i2c-hid-of: fix NULL-deref on failed power up
>
> Benjamin Tissoires <bentiss@kernel.org>
>     HID: bpf: actually free hdev memory after attaching a HID-BPF program
>
> Benjamin Tissoires <bentiss@kernel.org>
>     HID: bpf: remove double fdget()
>
> Luka Guzenko <l.guzenko@web.de>
>     ALSA: hda/realtek: Enable Mute LED on HP Laptop 14-fq0xxx
>
> David Senoner <seda18@rolmail.net>
>     ALSA: hda/realtek: Fix the external mic not being recognised for Acer=
 Swift 1 SF114-32
>
> Helge Deller <deller@gmx.de>
>     parisc: Prevent hung tasks when printing inventory on serial console
>
> Techno Mooney <techno.mooney@gmail.com>
>     ASoC: amd: yc: Add DMI quirk for MSI Bravo 15 C7VF
>
> Mikulas Patocka <mpatocka@redhat.com>
>     dm-crypt, dm-verity: disable tasklets
>
> Dave Airlie <airlied@redhat.com>
>     nouveau: offload fence uevents work to workqueue
>
> Michael Kelley <mhklinux@outlook.com>
>     scsi: storvsc: Fix ring buffer size calculation
>
> Nico Pache <npache@redhat.com>
>     selftests: mm: fix map_hugetlb failure on 64K page size systems
>
> Audra Mitchell <audra@redhat.com>
>     selftests/mm: Update va_high_addr_switch.sh to check CPU for la57 fla=
g
>
> Zach O'Keefe <zokeefe@google.com>
>     mm/writeback: fix possible divide-by-zero in wb_dirty_limits(), again
>
> Jan Kara <jack@suse.cz>
>     readahead: avoid multiple marked readahead pages
>
> Muhammad Usama Anjum <usama.anjum@collabora.com>
>     selftests/mm: switch to bash from sh
>
> Sidhartha Kumar <sidhartha.kumar@oracle.com>
>     fs/hugetlbfs/inode.c: mm/memory-failure.c: fix hugetlbfs hwpoison han=
dling
>
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>     tracing/trigger: Fix to return error if failed to alloc snapshot
>
> Samuel Holland <samuel.holland@sifive.com>
>     scs: add CONFIG_MMU dependency for vfree_atomic()
>
> Ryan Roberts <ryan.roberts@arm.com>
>     selftests/mm: ksm_tests should only MADV_HUGEPAGE valid memory
>
> Lokesh Gidra <lokeshgidra@google.com>
>     userfaultfd: fix mmap_changing checking in mfill_atomic_hugetlb
>
> Ryan Roberts <ryan.roberts@arm.com>
>     mm: thp_get_unmapped_area must honour topdown preference
>
> Ivan Vecera <ivecera@redhat.com>
>     i40e: Fix waiting for queues of all VSIs to be disabled
>
> Ivan Vecera <ivecera@redhat.com>
>     i40e: Do not allow untrusted VF to remove administratively set MAC
>
> Jiaxun Yang <jiaxun.yang@flygoat.com>
>     mm/memory: Use exception ip to search exception tables
>
> Jiaxun Yang <jiaxun.yang@flygoat.com>
>     ptrace: Introduce exception_ip arch hook
>
> Guenter Roeck <linux@roeck-us.net>
>     MIPS: Add 'memory' clobber to csum_ipv6_magic() inline assembler
>
> Arnd Bergmann <arnd@arndb.de>
>     nouveau/svm: fix kvcalloc() argument order
>
> Breno Leitao <leitao@debian.org>
>     net: sysfs: Fix /sys/class/net/<iface> path for statistics
>
> Manasi Navare <navaremanasi@chromium.org>
>     drm/i915/dsc: Fix the macro that calculates DSCC_/DSCA_ PPS reg addre=
ss
>
> Alexey Khoroshilov <khoroshilov@ispras.ru>
>     ASoC: rt5645: Fix deadlock in rt5645_jack_detect_work()
>
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>     spi: ppc4xx: Drop write-only variable
>
> Jakub Kicinski <kuba@kernel.org>
>     net: tls: fix returned read length with async decrypt
>
> Sabrina Dubroca <sd@queasysnail.net>
>     net: tls: fix use-after-free with partial reads and async decrypt
>
> Jakub Kicinski <kuba@kernel.org>
>     net: tls: handle backlogging of crypto requests
>
> Jakub Kicinski <kuba@kernel.org>
>     tls: fix race between tx work scheduling and socket close
>
> Jakub Kicinski <kuba@kernel.org>
>     tls: fix race between async notify and socket close
>
> Jakub Kicinski <kuba@kernel.org>
>     net: tls: factor out tls_*crypt_async_wait()
>
> Horatiu Vultur <horatiu.vultur@microchip.com>
>     lan966x: Fix crash when adding interface under a lag
>
> Aaron Conole <aconole@redhat.com>
>     net: openvswitch: limit the number of recursions from action sets
>
> Ido Schimmel <idosch@nvidia.com>
>     selftests: forwarding: Fix bridge locked port test flakiness
>
> Ido Schimmel <idosch@nvidia.com>
>     selftests: forwarding: Suppress grep warnings
>
> Ido Schimmel <idosch@nvidia.com>
>     selftests: forwarding: Fix bridge MDB test flakiness
>
> Ido Schimmel <idosch@nvidia.com>
>     selftests: forwarding: Fix layer 2 miss test flakiness
>
> Ido Schimmel <idosch@nvidia.com>
>     selftests: net: Fix bridge backup port test flakiness
>
> Hangbin Liu <liuhangbin@gmail.com>
>     selftests/net: convert test_bridge_backup_port.sh to run it in unique=
 namespace
>
> Hojin Nam <hj96.nam@samsung.com>
>     perf: CXL: fix mismatched cpmu event opcode
>
> Lukas Bulwahn <lukas.bulwahn@gmail.com>
>     ALSA: hda/cs35l56: select intended config FW_CS_DSP
>
> Saravana Kannan <saravanak@google.com>
>     of: property: Improve finding the supplier of a remote-endpoint prope=
rty
>
> Saravana Kannan <saravanak@google.com>
>     of: property: Improve finding the consumer of a remote-endpoint prope=
rty
>
> Parav Pandit <parav@nvidia.com>
>     devlink: Fix command annotation documentation
>
> Magnus Karlsson <magnus.karlsson@intel.com>
>     bonding: do not report NETDEV_XDP_ACT_XSK_ZEROCOPY
>
> Chuck Lever <chuck.lever@oracle.com>
>     net/handshake: Fix handshake_req_destroy_test1
>
> Jiri Pirko <jiri@resnulli.us>
>     net/mlx5: DPLL, Fix possible use after free after delayed work timer =
triggers
>
> Jiri Pirko <jiri@resnulli.us>
>     dpll: fix possible deadlock during netlink dump operation
>
> Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
>     ASoC: SOF: ipc3-topology: Fix pipeline tear down logic
>
> Dan Carpenter <dan.carpenter@linaro.org>
>     wifi: iwlwifi: uninitialized variable in iwl_acpi_get_ppag_table()
>
> Dan Carpenter <dan.carpenter@linaro.org>
>     wifi: iwlwifi: Fix some error codes
>
> Miri Korenblit <miriam.rachel.korenblit@intel.com>
>     wifi: iwlwifi: clear link_id in time_event
>
> Amadeusz S=C5=82awi=C5=84ski <amadeuszx.slawinski@linux.intel.com>
>     ASoC: Intel: avs: Fix dynamic port assignment when TDM is set
>
> Carlos Song <carlos.song@nxp.com>
>     spi: imx: fix the burst length at DMA mode and CPU mode
>
> Cezary Rojewski <cezary.rojewski@intel.com>
>     ASoC: Intel: avs: Fix pci_probe() error path
>
> Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
>     selftests/landlock: Fix capability for net_test
>
> Rob Clark <robdclark@chromium.org>
>     drm/msm/gem: Fix double resv lock aquire
>
> Christian A. Ehrhardt <lk@c--e.de>
>     of: unittest: Fix compile in the non-dynamic case
>
> Hu Yadi <hu.yadi@h3c.com>
>     selftests/landlock: Fix fs_test build with old libc
>
> Hu Yadi <hu.yadi@h3c.com>
>     selftests/landlock: Fix net_test build with old libc
>
> N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
>     kselftest: dt: Stop relying on dirname to improve performance
>
> Saravana Kannan <saravanak@google.com>
>     driver core: Fix device_link_flag_is_sync_state_only()
>
> Josef Bacik <josef@toxicpanda.com>
>     btrfs: don't drop extent_map for free space inode on write error
>
> Filipe Manana <fdmanana@suse.com>
>     btrfs: reject encoded write if inode has nodatasum flag set
>
> Filipe Manana <fdmanana@suse.com>
>     btrfs: don't reserve space for checksums when writing to nocow files
>
> David Sterba <dsterba@suse.com>
>     btrfs: send: return EOPNOTSUPP on unknown flags
>
> Boris Burkov <boris@bur.io>
>     btrfs: forbid deleting live subvol qgroup
>
> Qu Wenruo <wqu@suse.com>
>     btrfs: do not ASSERT() if the newly created subvolume already got rea=
d
>
> Boris Burkov <boris@bur.io>
>     btrfs: forbid creating subvol qgroups
>
> Filipe Manana <fdmanana@suse.com>
>     btrfs: don't refill whole delayed refs block reserve when starting tr=
ansaction
>
> Filipe Manana <fdmanana@suse.com>
>     btrfs: add new unused block groups to the list of unused block groups
>
> Filipe Manana <fdmanana@suse.com>
>     btrfs: do not delete unused block group if it may be used soon
>
> Filipe Manana <fdmanana@suse.com>
>     btrfs: add and use helper to check if block group is used
>
> Yang Shi <yang@os.amperecomputing.com>
>     mm: mmap: map MAP_STACK to VM_NOHUGEPAGE
>
> Yang Shi <yang@os.amperecomputing.com>
>     mm: huge_memory: don't force huge page alignment on 32 bit
>
> Linus Torvalds <torvalds@linux-foundation.org>
>     update workarounds for gcc "asm goto" issue
>
> Linus Torvalds <torvalds@linux-foundation.org>
>     work around gcc bugs with 'asm goto' with outputs
>
>
> -------------
>
> Diffstat:
>
>  .../ABI/testing/sysfs-class-net-statistics         |  48 +-
>  Documentation/arch/arm64/silicon-errata.rst        |   7 +
>  Documentation/netlink/specs/dpll.yaml              |   4 -
>  Documentation/networking/devlink/devlink-port.rst  |   2 +-
>  Documentation/sphinx/kernel_feat.py                |   2 +-
>  Makefile                                           |   4 +-
>  arch/Kconfig                                       |   1 +
>  arch/arc/include/asm/jump_label.h                  |   4 +-
>  arch/arm/include/asm/jump_label.h                  |   4 +-
>  arch/arm64/include/asm/alternative-macros.h        |   4 +-
>  arch/arm64/include/asm/cputype.h                   |   4 +
>  arch/arm64/include/asm/jump_label.h                |   4 +-
>  arch/arm64/kernel/cpu_errata.c                     |   3 +
>  arch/arm64/kernel/fpsimd.c                         |   2 +-
>  arch/arm64/kernel/signal.c                         |   4 +-
>  arch/arm64/kvm/pkvm.c                              |  27 +-
>  arch/csky/include/asm/jump_label.h                 |   4 +-
>  arch/loongarch/include/asm/jump_label.h            |   4 +-
>  arch/loongarch/mm/kasan_init.c                     |   3 +
>  arch/mips/include/asm/checksum.h                   |   3 +-
>  arch/mips/include/asm/jump_label.h                 |   4 +-
>  arch/mips/include/asm/ptrace.h                     |   2 +
>  arch/mips/kernel/ptrace.c                          |   7 +
>  arch/parisc/Kconfig                                |   1 -
>  arch/parisc/include/asm/assembly.h                 |   1 +
>  arch/parisc/include/asm/extable.h                  |  64 ++
>  arch/parisc/include/asm/jump_label.h               |   4 +-
>  arch/parisc/include/asm/special_insns.h            |   6 +-
>  arch/parisc/include/asm/uaccess.h                  |  48 +-
>  arch/parisc/kernel/cache.c                         |   6 +-
>  arch/parisc/kernel/drivers.c                       |   3 +
>  arch/parisc/kernel/unaligned.c                     |  44 +-
>  arch/parisc/mm/fault.c                             |  11 +-
>  arch/powerpc/include/asm/jump_label.h              |   4 +-
>  arch/powerpc/include/asm/reg.h                     |   2 +
>  arch/powerpc/include/asm/thread_info.h             |   2 +-
>  arch/powerpc/include/asm/uaccess.h                 |  12 +-
>  arch/powerpc/kernel/cpu_setup_6xx.S                |  20 +-
>  arch/powerpc/kernel/cpu_specs_e500mc.h             |   3 +-
>  arch/powerpc/kernel/interrupt_64.S                 |   4 +-
>  arch/powerpc/kernel/iommu.c                        |   4 +-
>  arch/powerpc/kernel/irq_64.c                       |   2 +-
>  arch/powerpc/mm/kasan/init_32.c                    |   1 +
>  arch/powerpc/platforms/pseries/lpar.c              |   8 +-
>  arch/riscv/include/asm/bitops.h                    |   8 +-
>  arch/riscv/include/asm/cpufeature.h                |   4 +-
>  arch/riscv/include/asm/jump_label.h                |   4 +-
>  arch/s390/include/asm/jump_label.h                 |   4 +-
>  arch/s390/kvm/vsie.c                               |   1 -
>  arch/s390/mm/gmap.c                                |   1 +
>  arch/sparc/include/asm/jump_label.h                |   4 +-
>  arch/um/Makefile                                   |   4 +-
>  arch/um/include/asm/cpufeature.h                   |   2 +-
>  arch/x86/Kconfig.cpu                               |   2 +-
>  arch/x86/include/asm/cpufeature.h                  |   2 +-
>  arch/x86/include/asm/jump_label.h                  |   6 +-
>  arch/x86/include/asm/rmwcc.h                       |   2 +-
>  arch/x86/include/asm/special_insns.h               |   2 +-
>  arch/x86/include/asm/uaccess.h                     |  10 +-
>  arch/x86/kernel/fpu/signal.c                       |  13 +-
>  arch/x86/kvm/svm/svm_ops.h                         |   6 +-
>  arch/x86/kvm/vmx/pmu_intel.c                       |   2 +-
>  arch/x86/kvm/vmx/vmx.c                             |   4 +-
>  arch/x86/kvm/vmx/vmx_ops.h                         |   6 +-
>  arch/x86/kvm/x86.c                                 |   3 +-
>  arch/x86/mm/ident_map.c                            |  23 +-
>  arch/xtensa/include/asm/jump_label.h               |   4 +-
>  block/blk-mq.c                                     |   9 +-
>  block/blk-wbt.c                                    |   4 +-
>  crypto/algif_hash.c                                |   5 +-
>  drivers/android/binder.c                           |  10 +
>  drivers/base/core.c                                |  15 +-
>  drivers/base/power/domain.c                        |   2 +-
>  drivers/connector/cn_proc.c                        |   5 +-
>  drivers/crypto/ccp/sev-dev.c                       |  10 +-
>  drivers/dpll/dpll_netlink.c                        |  20 +-
>  drivers/dpll/dpll_nl.c                             |   4 -
>  drivers/dpll/dpll_nl.h                             |   2 -
>  drivers/firewire/core-device.c                     |   7 +-
>  drivers/firmware/efi/libstub/Makefile              |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |   9 +-
>  drivers/gpu/drm/amd/amdgpu/cik_ih.c                |   6 +
>  drivers/gpu/drm/amd/amdgpu/cz_ih.c                 |   5 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |   2 -
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |   8 -
>  drivers/gpu/drm/amd/amdgpu/iceland_ih.c            |   5 +
>  drivers/gpu/drm/amd/amdgpu/ih_v6_0.c               |   6 +
>  drivers/gpu/drm/amd/amdgpu/ih_v6_1.c               |   7 +
>  drivers/gpu/drm/amd/amdgpu/navi10_ih.c             |   6 +
>  drivers/gpu/drm/amd/amdgpu/si_ih.c                 |   6 +
>  drivers/gpu/drm/amd/amdgpu/soc21.c                 |   4 +-
>  drivers/gpu/drm/amd/amdgpu/tonga_ih.c              |   6 +
>  drivers/gpu/drm/amd/amdgpu/vega10_ih.c             |   6 +
>  drivers/gpu/drm/amd/amdgpu/vega20_ih.c             |   6 +
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  14 +-
>  .../amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   |  15 +-
>  drivers/gpu/drm/amd/display/dc/dml/Makefile        |   6 +-
>  .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   |   2 +-
>  .../amd/display/dc/dml2/dml2_translation_helper.c  |  27 +-
>  drivers/gpu/drm/amd/display/dc/inc/core_types.h    |   2 +
>  .../display/dc/link/protocols/link_dp_training.c   |   5 +-
>  drivers/gpu/drm/drm_buddy.c                        |   6 +
>  drivers/gpu/drm/drm_prime.c                        |   2 +-
>  drivers/gpu/drm/i915/display/intel_dp.c            |   3 +
>  drivers/gpu/drm/i915/display/intel_vdsc_regs.h     |   4 +-
>  drivers/gpu/drm/msm/msm_gem_prime.c                |   4 +-
>  drivers/gpu/drm/msm/msm_gpu.c                      |  11 +-
>  drivers/gpu/drm/msm/msm_iommu.c                    |  32 +-
>  drivers/gpu/drm/msm/msm_ringbuffer.c               |   7 +-
>  drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h  |   2 +-
>  drivers/gpu/drm/nouveau/nouveau_fence.c            |  26 +-
>  drivers/gpu/drm/nouveau/nouveau_fence.h            |   1 +
>  drivers/gpu/drm/nouveau/nouveau_svm.c              |   2 +-
>  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c     |  61 +-
>  drivers/gpu/drm/virtio/virtgpu_drv.c               |   1 +
>  drivers/hid/bpf/hid_bpf_dispatch.c                 |  83 ++-
>  drivers/hid/bpf/hid_bpf_dispatch.h                 |   4 +-
>  drivers/hid/bpf/hid_bpf_jmp_table.c                |  40 +-
>  drivers/hid/i2c-hid/i2c-hid-of.c                   |   1 +
>  drivers/hid/wacom_sys.c                            |  63 +-
>  drivers/hid/wacom_wac.c                            |   9 +-
>  drivers/i2c/busses/Makefile                        |   6 +-
>  drivers/i2c/busses/i2c-i801.c                      |   4 +-
>  drivers/i2c/busses/i2c-pasemi-core.c               |   6 +
>  drivers/i2c/busses/i2c-qcom-geni.c                 |  16 +-
>  drivers/iio/accel/Kconfig                          |   2 +
>  drivers/iio/adc/ad4130.c                           |  12 +-
>  drivers/iio/imu/bno055/Kconfig                     |   1 +
>  drivers/iio/industrialio-core.c                    |   5 +-
>  drivers/iio/light/hid-sensor-als.c                 |   1 +
>  drivers/iio/magnetometer/rm3100-core.c             |  10 +-
>  drivers/iio/pressure/bmp280-spi.c                  |   1 +
>  drivers/interconnect/qcom/sc8180x.c                |   1 +
>  drivers/interconnect/qcom/sm8550.c                 |   1 +
>  drivers/irqchip/irq-brcmstb-l2.c                   |   5 +-
>  drivers/irqchip/irq-gic-v3-its.c                   |  62 +-
>  drivers/irqchip/irq-loongson-eiointc.c             |   2 +-
>  drivers/md/dm-crypt.c                              |  38 +-
>  drivers/md/dm-verity-target.c                      |  26 +-
>  drivers/md/dm-verity.h                             |   1 -
>  drivers/md/md.c                                    |   7 +-
>  .../media/platform/rockchip/rkisp1/rkisp1-dev.c    |   2 +-
>  drivers/media/rc/bpf-lirc.c                        |   6 +-
>  drivers/media/rc/ir_toy.c                          |   2 +
>  drivers/media/rc/lirc_dev.c                        |   5 +-
>  drivers/media/rc/rc-core-priv.h                    |   2 +-
>  drivers/misc/fastrpc.c                             |   2 +-
>  drivers/mmc/core/slot-gpio.c                       |   6 +-
>  drivers/mmc/host/sdhci-pci-o2micro.c               |  30 +
>  drivers/net/bonding/bond_main.c                    |   5 +-
>  drivers/net/can/dev/netlink.c                      |   2 +-
>  drivers/net/dsa/mv88e6xxx/chip.c                   |   2 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c        |   2 +-
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  38 +-
>  drivers/net/ethernet/mellanox/mlx5/core/dpll.c     |   2 +-
>  .../net/ethernet/microchip/lan966x/lan966x_lag.c   |   9 +-
>  .../net/ethernet/netronome/nfp/flower/conntrack.c  |  46 +-
>  .../ethernet/netronome/nfp/flower/tunnel_conf.c    |   2 +-
>  .../net/ethernet/netronome/nfp/nfp_net_common.c    |   1 +
>  .../ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c  |   6 +-
>  drivers/net/ethernet/stmicro/stmmac/common.h       |  56 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |  15 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c   |  15 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c    |  15 +-
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c |  15 +-
>  .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   | 125 +++-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 136 ++--
>  drivers/net/ethernet/ti/cpsw.c                     |   2 +
>  drivers/net/ethernet/ti/cpsw_new.c                 |   3 +
>  drivers/net/hyperv/netvsc.c                        |   5 +-
>  drivers/net/hyperv/netvsc_drv.c                    |  82 ++-
>  drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |  15 +-
>  drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |   1 +
>  drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   3 +
>  drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |   4 +
>  .../net/wireless/intel/iwlwifi/mvm/time-event.c    |   3 +-
>  drivers/net/xen-netback/netback.c                  | 100 ++-
>  drivers/of/property.c                              |  61 +-
>  drivers/of/unittest.c                              |  12 +-
>  drivers/pci/controller/dwc/pcie-designware-ep.c    |   3 +-
>  drivers/pci/pci.c                                  |  37 +-
>  drivers/perf/cxl_pmu.c                             |   2 +-
>  drivers/pmdomain/mediatek/mtk-pm-domains.c         |  15 +-
>  drivers/pmdomain/renesas/r8a77980-sysc.c           |   3 +-
>  drivers/s390/net/qeth_l3_main.c                    |   9 +-
>  drivers/scsi/fcoe/fcoe_ctlr.c                      |  20 +-
>  drivers/scsi/storvsc_drv.c                         |  12 +-
>  drivers/spi/spi-imx.c                              |   9 +-
>  drivers/spi/spi-omap2-mcspi.c                      | 137 +---
>  drivers/spi/spi-ppc4xx.c                           |   5 -
>  drivers/staging/iio/impedance-analyzer/ad5933.c    |   2 +-
>  drivers/thunderbolt/tb_regs.h                      |   2 +-
>  drivers/thunderbolt/usb4.c                         |   2 +-
>  drivers/tty/serial/max310x.c                       |  53 +-
>  drivers/tty/serial/mxs-auart.c                     |   5 +-
>  drivers/tty/serial/serial_core.c                   |   2 +-
>  drivers/usb/chipidea/ci.h                          |   2 +
>  drivers/usb/chipidea/core.c                        |  44 +-
>  drivers/usb/common/ulpi.c                          |   2 +-
>  drivers/usb/core/hub.c                             |  46 +-
>  drivers/usb/dwc3/gadget.c                          |   6 +-
>  drivers/usb/gadget/function/f_mass_storage.c       |  20 +-
>  drivers/usb/typec/tcpm/tcpm.c                      |   3 +-
>  drivers/usb/typec/ucsi/ucsi.c                      |   2 +
>  drivers/usb/typec/ucsi/ucsi_acpi.c                 |  17 +-
>  drivers/xen/events/events_base.c                   |   8 +-
>  fs/btrfs/block-group.c                             |  80 +-
>  fs/btrfs/block-group.h                             |   7 +
>  fs/btrfs/delalloc-space.c                          |  29 +-
>  fs/btrfs/disk-io.c                                 |  13 +-
>  fs/btrfs/inode.c                                   |  26 +-
>  fs/btrfs/ioctl.c                                   |   5 +
>  fs/btrfs/qgroup.c                                  |  14 +
>  fs/btrfs/send.c                                    |   2 +-
>  fs/btrfs/transaction.c                             |  38 +-
>  fs/ceph/caps.c                                     |   3 +-
>  fs/ext4/mballoc.c                                  |  39 +-
>  fs/ext4/move_extent.c                              |   6 +-
>  fs/hugetlbfs/inode.c                               |  21 +-
>  fs/namespace.c                                     |  11 +-
>  fs/nfsd/nfs4state.c                                |  11 +-
>  fs/nilfs2/file.c                                   |   8 +-
>  fs/nilfs2/recovery.c                               |   7 +-
>  fs/proc/array.c                                    |  66 +-
>  fs/smb/client/connect.c                            |  14 +-
>  fs/smb/client/fs_context.c                         |  11 +
>  fs/smb/client/namespace.c                          |  16 +
>  fs/smb/client/smb2ops.c                            |   2 +-
>  fs/smb/server/smb2pdu.c                            |   8 +-
>  fs/tracefs/event_inode.c                           | 814 ++++++---------=
------
>  fs/tracefs/inode.c                                 | 102 +--
>  fs/tracefs/internal.h                              |  46 +-
>  fs/zonefs/file.c                                   |  42 +-
>  fs/zonefs/super.c                                  |  66 +-
>  include/linux/backing-dev-defs.h                   |   7 +-
>  include/linux/compiler-gcc.h                       |  20 +
>  include/linux/compiler_types.h                     |  11 +-
>  include/linux/gpio/driver.h                        |  12 +
>  include/linux/iio/adc/ad_sigma_delta.h             |   4 +-
>  include/linux/iio/common/st_sensors.h              |   4 +-
>  include/linux/iio/imu/adis.h                       |   3 +-
>  include/linux/lsm_hook_defs.h                      |   4 +-
>  include/linux/mman.h                               |   1 +
>  include/linux/netfilter/ipset/ip_set.h             |   4 +
>  include/linux/ptrace.h                             |   4 +
>  include/linux/serial_core.h                        |  32 +-
>  include/net/tls.h                                  |   5 -
>  include/sound/tas2781.h                            |   1 +
>  init/Kconfig                                       |   9 +
>  io_uring/net.c                                     |   5 +-
>  kernel/sys.c                                       |  54 +-
>  kernel/trace/ftrace.c                              |  10 +
>  kernel/trace/ring_buffer.c                         |   2 +-
>  kernel/trace/trace.c                               |  78 +-
>  kernel/trace/trace_btf.c                           |   4 +-
>  kernel/trace/trace_events_synth.c                  |   3 +-
>  kernel/trace/trace_events_trigger.c                |   6 +-
>  kernel/trace/trace_osnoise.c                       |   6 +-
>  kernel/trace/trace_probe.c                         |  32 +-
>  kernel/trace/trace_probe.h                         |   3 +-
>  kernel/workqueue.c                                 |   8 +-
>  lib/kobject.c                                      |  24 +-
>  mm/backing-dev.c                                   |   2 +-
>  mm/damon/sysfs-schemes.c                           |   2 +-
>  mm/huge_memory.c                                   |  14 +-
>  mm/memory-failure.c                                |   2 +-
>  mm/memory.c                                        |   4 +-
>  mm/mmap.c                                          |   6 +-
>  mm/page-writeback.c                                |   4 +-
>  mm/readahead.c                                     |   4 +-
>  mm/userfaultfd.c                                   |  15 +-
>  net/can/j1939/j1939-priv.h                         |   3 +-
>  net/can/j1939/main.c                               |   2 +-
>  net/can/j1939/socket.c                             |  46 +-
>  net/handshake/handshake-test.c                     |   5 +-
>  net/hsr/hsr_device.c                               |   4 +-
>  net/mac80211/tx.c                                  |   5 +-
>  net/mptcp/pm_userspace.c                           |  13 +-
>  net/mptcp/protocol.c                               |  25 +-
>  net/mptcp/protocol.h                               |   7 +-
>  net/mptcp/subflow.c                                |   4 +-
>  net/netfilter/ipset/ip_set_bitmap_gen.h            |  14 +-
>  net/netfilter/ipset/ip_set_core.c                  |  39 +-
>  net/netfilter/ipset/ip_set_hash_gen.h              |  19 +-
>  net/netfilter/ipset/ip_set_list_set.c              |  13 +-
>  net/netfilter/nft_set_pipapo_avx2.c                |   2 +-
>  net/nfc/nci/core.c                                 |   4 +
>  net/openvswitch/flow_netlink.c                     |  49 +-
>  net/tls/tls_sw.c                                   | 135 ++--
>  net/wireless/core.c                                |   3 +-
>  samples/bpf/asm_goto_workaround.h                  |   8 +-
>  scripts/link-vmlinux.sh                            |   9 +-
>  scripts/mksysmap                                   |  13 +-
>  scripts/mod/modpost.c                              |   3 +-
>  scripts/mod/sumversion.c                           |   7 +-
>  security/security.c                                |  45 +-
>  sound/pci/hda/Kconfig                              |   4 +-
>  sound/pci/hda/patch_conexant.c                     |  18 +
>  sound/pci/hda/patch_cs8409.c                       |   1 +
>  sound/pci/hda/patch_realtek.c                      |  20 +-
>  sound/pci/hda/tas2781_hda_i2c.c                    |   2 +-
>  sound/soc/amd/yc/acp6x-mach.c                      |  14 +
>  sound/soc/codecs/rt5645.c                          |   1 +
>  sound/soc/codecs/tas2781-comlib.c                  |   3 +-
>  sound/soc/codecs/tas2781-i2c.c                     |   2 +-
>  sound/soc/codecs/wcd938x.c                         |   2 +-
>  sound/soc/intel/avs/core.c                         |   3 +
>  sound/soc/intel/avs/topology.c                     |   2 +-
>  sound/soc/sof/ipc3-topology.c                      |  69 +-
>  sound/soc/sof/ipc3.c                               |   2 +-
>  tools/arch/x86/include/asm/rmwcc.h                 |   2 +-
>  tools/include/linux/compiler_types.h               |   4 +-
>  .../testing/selftests/dt/test_unprobed_devices.sh  |  13 +-
>  tools/testing/selftests/landlock/common.h          |  48 +-
>  tools/testing/selftests/landlock/fs_test.c         |  11 +-
>  tools/testing/selftests/landlock/net_test.c        |  13 +-
>  .../selftests/mm/charge_reserved_hugetlb.sh        |   2 +-
>  tools/testing/selftests/mm/ksm_tests.c             |   2 +-
>  tools/testing/selftests/mm/map_hugetlb.c           |   7 +
>  tools/testing/selftests/mm/va_high_addr_switch.sh  |   6 +
>  tools/testing/selftests/mm/write_hugetlb_memory.sh |   2 +-
>  .../selftests/net/forwarding/bridge_locked_port.sh |   4 +-
>  .../testing/selftests/net/forwarding/bridge_mdb.sh |  14 +-
>  .../selftests/net/forwarding/tc_flower_l2_miss.sh  |   8 +-
>  tools/testing/selftests/net/mptcp/config           |   3 +
>  tools/testing/selftests/net/mptcp/mptcp_join.sh    |  10 +-
>  tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  11 +-
>  tools/testing/selftests/net/mptcp/settings         |   2 +-
>  tools/testing/selftests/net/mptcp/userspace_pm.sh  |  31 +-
>  .../selftests/net/test_bridge_backup_port.sh       | 394 +++++-----
>  tools/tracing/rtla/Makefile                        |   7 +-
>  tools/tracing/rtla/src/osnoise_hist.c              |   9 +-
>  tools/tracing/rtla/src/osnoise_top.c               |   6 +-
>  tools/tracing/rtla/src/timerlat_hist.c             |   9 +-
>  tools/tracing/rtla/src/timerlat_top.c              |   6 +-
>  tools/tracing/rtla/src/utils.c                     |  14 +-
>  tools/tracing/rtla/src/utils.h                     |   2 +
>  tools/verification/rv/Makefile                     |   7 +-
>  tools/verification/rv/src/in_kernel.c              |   2 +-
>  340 files changed, 3297 insertions(+), 2530 deletions(-)
>
>
>

